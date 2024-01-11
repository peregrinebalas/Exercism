package chessboard

// Declare a type named File which stores if a square is occupied by a piece - this will be a slice of bools
type File []bool

// Declare a type named Chessboard which contains a map of eight Files, accessed with keys from "A" to "H"
type Chessboard map[string]File

// CountInFile returns how many squares are occupied in the chessboard,
// within the given file.
func CountInFile(cb Chessboard, file string) int {
	ranks, exists := cb[file]
	if exists {
		occupied := 0
		for _, rank := range ranks {
			if rank {
				occupied++
			}
		}
		return occupied
	}
	return 0
}

// CountInRank returns how many squares are occupied in the chessboard,
// within the given rank.
func CountInRank(cb Chessboard, rank int) int {
	if rank >= 1 && rank <= 8 {
		occupied := 0
		for _, file := range cb {
			for i, rankVal := range file {
				if i+1 == rank && rankVal {
					occupied++
				}
			}
		}
		return occupied
	}
	return 0
}

// CountAll should count how many squares are present in the chessboard.
func CountAll(cb Chessboard) int {
	total := 0
	for _, file := range cb {
		total += len(file)
	}
	return total
}

// CountOccupied returns how many squares are occupied in the chessboard.
func CountOccupied(cb Chessboard) int {
	occupied := 0
	for key, _ := range cb {
		occupied += CountInFile(cb, key)
	}

	return occupied
}
