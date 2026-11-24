import brute_force as bf
import numpy as np
from PIL import Image
import time

class Viewer:
    def __init__(self):
        self.bf_calculater = bf.MandelbrotBruteForcer()
        self.xmin = 0
        self.xmax = 0
        self.imin = 0
        self.imax = 0
        self.width = 0
        self.height = 0
        self.iterations = 0

    def SetAttributes(self, xmin: float, xmax: float, imin: float, imax: float, width: int, height: int, iterations: int) -> None:
        self.xmin = xmin
        self.xmax = xmax
        self.imin = imin
        self.imax = imax
        self.width = width
        self.height = height
        self.iterations = iterations

    def Calculate(self, method: int) -> None:
        st = time.time_ns()
        match method:
            case 0:
                self.pixel_data = self.bf_calculater.CalculateMandelbrot(self.xmin, self.xmax, self.imin, self.imax, self.width, self.height, self.iterations)

        print(f"Finished calculating in {(time.time_ns() - st)/1e6} ms")

    def Draw(self, colour , fill, debug: bool = False) -> None:
        st = time.time_ns()

        img_data = self._convert_data(self.pixel_data)

        img = Image.fromarray(img_data)
        img.save("test.jpg")

        if debug:
            with open("test.txt", "w") as f:
                for arr in self.pixel_data:
                    for i in arr:
                        f.write(str(i)); f.write(", ")
                    f.write("\n")

        print(f"Finished drawing in {(time.time_ns() - st)/1e6} ms")

    def _convert_data(self, data: np.ndarray) -> np.ndarray:
        return np.uint8(255-data*255/self.iterations)




viewer = Viewer()

xmin = -2.25
xmax = 0.75
imin = -1.5
imax = 1.5
width = 1000
height = 800
iterations = 200

viewer.SetAttributes(xmin, xmax, imin, imax, width, height, iterations)
viewer.Calculate(0)
viewer.Draw(1,1)