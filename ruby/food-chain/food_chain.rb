class FoodChain
    @@animals = [:fly, :spider, :bird, :cat, :dog, :goat, :cow, :horse]
    @@animal_lyrics = {
        fly: "I don't know why she swallowed the fly. Perhaps she'll die.\n\n",
        spider: "wriggled and jiggled and tickled inside her.\n",
        bird: "How absurd to swallow a bird!\n",
        cat: "Imagine that, to swallow a cat!\n",
        dog: "What a hog, to swallow a dog!\n",
        goat: "Just opened her throat and swallowed a goat!\n",
        cow: "I don't know how she swallowed a cow!\n",
        horse: "She's dead, of course!\n"
    }

    def self.song
        @@animals.map.with_index do |animal, i|
            rhyme = @@animal_lyrics[animal]
            verse = old_lady_lyric(animal)
            verse += i == 1 ? "It #{rhyme}" : rhyme

            unless i == 0 || i == @@animals.length - 1 then
                countdown = i
                while countdown > 0 do
                    verse += swallowed_lyric(countdown)
                    countdown -= 1
                end
                verse += @@animal_lyrics[:fly]
            end
            verse
        end.join("")
    end

    private

    def self.old_lady_lyric(animal)
        "I know an old lady who swallowed a #{animal}.\n"
    end

    def self.swallowed_lyric(i)
        predator = @@animals[i]
        prey = @@animals[i - 1]
        end_segment = i - 1 == 1 ? " that #{@@animal_lyrics[prey]}" : ".\n"
        "She swallowed the #{predator} to catch the #{prey}#{end_segment}"
    end
end