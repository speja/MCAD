import io, argparse, string

class stlobject:
    "An STL 3D object model"
    
    class facet:
        """
        facet normal ni nj nk
        outer loop
        vertex v1x v1y v1z
        vertex v2x v2y v2z
        vertex v3x v3y v3z
        endloop
        endfacet
        """
        def __init__(self, buf = None):
            if buf:
                self.read(buf)
            else:
                raise Exception("Not implemented")

        @staticmethod
        def skipspace(buf):
            "skip space and return first non-space"
            c = buf.read(1)
            while c in string.whitespace and c != '':
                c = buf.read(1)
            return c
        @staticmethod
        def readtoken(buf):
            "Find token, separated by white space"
            c = stlobject.facet.skipspace(buf)
            t = ''
            while c not in string.whitespace:
                t = t + c
                c = buf.read(1)
            return t
        
        @staticmethod
        def findtoken(buf, token):
            t = stlobject.facet.readtoken(buf)
            if t == token:
                return
            raise Exception('expected {}, found {}'.format(token, t))
        
        def read(self, buf):
            self.findtoken(buf, 'facet')
            self.findtoken(buf, 'normal')
            self.ni = float(self.readtoken(buf)) # ni
            self.nj = float(self.readtoken(buf)) # nj
            self.nk = float(self.readtoken(buf)) # nk
            self.findtoken(buf, 'outer')
            self.findtoken(buf, 'loop')
            self.findtoken(buf, 'vertex')
            self.v1x = float(self.readtoken(buf)) # v1x
            self.v1y = float(self.readtoken(buf)) # v1y
            self.v1z = float(self.readtoken(buf)) # v1z
            self.findtoken(buf, 'vertex')
            self.v2x = float(self.readtoken(buf)) # v2x
            self.v2y = float(self.readtoken(buf)) # v2y
            self.v2z = float(self.readtoken(buf)) # v2z
            self.findtoken(buf, 'vertex')
            self.v3x = float(self.readtoken(buf)) # v3x
            self.v3y = float(self.readtoken(buf)) # v3y
            self.v3z = float(self.readtoken(buf)) # v3z
            self.findtoken(buf, 'endloop')
            self.findtoken(buf, 'endfacet')
            
    def __init__(self):
        self.facets = []
        self.points = []

    def read(self, fn):
        self.readasc(fn)

    def readasc(self, fn):
        with open(fn, 'rt') as f:
            # read 'solid OpenSCAD_Model'            
            self.facet.findtoken(f, 'solid')
            self.name  = self.facet.readtoken(f)

            # Read the facets
            while True:
                try:
                    p = f.tell()
                    self.facets.append(stlobject.facet(f))
                except: # Found end of facet list !?
                    p = f.seek(p, io.SEEK_SET) # retry with endmarker
                    # expect end of solid
                    self.facet.findtoken(f, 'endsolid')
                    self.facet.findtoken(f, self.name)
                    break
            

    def readbin(self, fn):
        raise NotImplementedError("Can't read binary STL: {}".format(fn))

    def extract_points(self):
        for f in self.facets:
            p = (f.v1x, f.v1y, f.v1z)
            if self.points.count(p) == 0:
                self.points.append(p)
            f.v1 = self.points.index(p)
            p = (f.v2x, f.v2y, f.v2z)
            if self.points.count(p) == 0:
                self.points.append(p)
            f.v2 = self.points.index(p)
            p = (f.v3x, f.v3y, f.v3z)
            if self.points.count(p) == 0:
                self.points.append(p)
            f.v3 = self.points.index(p)

    def polyhedron(self, fn):
        with open(fn, 'wt') as f:
            f.write('module {} () {}\n'.format(self.name, '{')) # FIXME
            f.write(' points = [\n')
            for p in self.points:
                f.write('  [{}, {}, {}],\n'.format(p[0], p[1], p[2]))
            f.write(' ];\n')
            f.write(' faces = [\n')
            for facet in self.facets:
                f.write('  [{}, {}, {}],\n'.format(facet.v1, facet.v2, facet.v3))
            f.write(' ];\n')
            f.write(' polyhedron(points = points, faces = faces);\n')
            f.write('}\n')

if __name__ == "__main__":
    def outputfiletype(s):
        return s == 'scad'
        raise argparse.ArgumentTypeError('not accepted: {}'.format(s))
    
    parser = argparse.ArgumentParser(description='Convert 3D solid file format')
    parser.add_argument('infile', type=str, help='input file name')
    parser.add_argument('-o', type=outputfiletype,
                    help='output file format')
    parser.add_argument('outfile', type=str, help="filename");
    a = parser.parse_args()

    stl = stlobject()
    stl.read(a.infile)
    stl.extract_points()
    stl.polyhedron(a.outfile)
    
    
