class FoodChain
    @@animal_lyrics = [
       {fly: "I don't know why she swallowed the fly. Perhaps she'll die.\n\n"},
       {spider: " wriggled and jiggled and tickled inside her.\n"},
       {bird: "How absurd to swallow a bird!\n"},
       {cat: "Imagine that, to swallow a cat!\n"},
       {dog: "What a hog, to swallow a dog!\n"},
       {goat: "Just opened her throat and swallowed a goat!\n"},
       {cow: "I don't know how she swallowed a cow!\n"},
       {horse: "She's dead, of course!\n"}
    ]

    def self.song
        verses = @@animal_lyrics.map.with_index do |hash, i|
            animal = hash.keys.first
            rhyme = hash[animal]

            verse = old_lady_lyric(animal)
            verse += i == 1 ? "It#{rhyme}" : rhyme

            unless i == 0 || i == @@animal_lyrics.length - 1 then
                countdown = i
                while countdown > 0 do
                    prey = @@animal_lyrics[countdown - 1].keys.first
                    verse += swallowed_lyric(countdown)

                    countdown -= 1
                end

                verse += @@animal_lyrics[0][:fly]
            end
            verse
        end

        verses.join("")
    end

    private

    def self.old_lady_lyric(animal)
        "I know an old lady who swallowed a #{animal}.\n"
    end

    def self.swallowed_lyric(i)
        predator = @@animal_lyrics[i].keys.first
        prey = @@animal_lyrics[i - 1].keys.first
        fin = prey == :spider ? " that" + @@animal_lyrics[1][:spider] : ".\n"
        "She swallowed the #{predator} to catch the #{prey}" + fin
    end
end