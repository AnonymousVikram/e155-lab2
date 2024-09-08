hexInputs = [
    "0000",
    "0001",
    "0010",
    "0011",
    "0100",
    "0101",
    "0110",
    "0111",
    "1000",
    "1001",
    "1010",
    "1011",
    "1100",
    "1101",
    "1110",
    "1111",
]


def testgen():
    # write to the file
    with open("testbench.tv", "w") as f:
        for i in hexInputs:
            for j in hexInputs:
                f.write(f"{i}_{j}_1_0_{i}\n")
                f.write(f"{i}_{j}_0_1_{j}\n")


if __name__ == "__main__":
    testgen()
