os.execute("cls")
print("     =======================\n")
print("         #      #      ####")
print("        #      #      #    #")
print("       #      #      #    #")
print("      #      #      #   #")
print("     #####  #####  ####")
print("\n    =======================")
print("\n    LAVNIA LANGUAGE DATABASE")
print("           TERMINAL")
print("    ________________________\n")
print("     Habsieg M. Fergeni 161")
print("       est. May 6th 2025\n")
print("\n\n[[ type 'helpc' or '?c' for commands list ]]")
print("[[ type 'helpg' or '?g' for grammar help ]]\n")

local file = "C:/lua/LAVNIA_Dict/dict.txt"
local classes = {
    [1] = "Noun",
    [2] = "Verb",
    [3] = "Adjective",
    [4] = "Preposition",
    [5] = "Conjunction",
    [6] = "Interjection",
    [7] = "Article",
    [8] = "Pronoun"
}
local forms = {
    [1] = "Standard",
    [2] = "Prefix",
    [3] = "Suffix"
}

while true do

    io.write("[] >")
    local inp = io.read()
    local inp2 = {}
    for i in string.gmatch(inp, "%S+") do
        table.insert(inp2, i)
    end
    
    -- ################# input #################
    if #inp2 > 0 then
        if (inp2[1] == "helpc" or inp2[1] == "?c") and #inp2 == 1 then
            print("\n[[ current useable commands: ]]")
            print("===============================")
            print("\t[main]\t||\t[alt.]")
            print("===============================")
            print("-\thelpc\t||\t?c\t: Lists available commands (this)")
            print("-\thelpg\t||\t?g\t: Grammar Help")
            print("-\tclear\t||\tcls\t: Clears the screen")
            print("-\tter\t||\tx\t: Terminates the session (exit)")
            print("-\tread\t||\tr\t: Outputs database contents")
            print("-\tadd\t||\t+\t: Adds a new entry/definition to the Database")
            print("-\trem\t||\t-\t: Removes a selected entry from the Database")
            print("-\trep\t||\t//\t: Replaces an entry's name in the Database")
            print("-\tsch\t||\ts\t: Search by content")
            print("\nsidenotes :\n- 'ae' is pronounced like the e in 'Merry'")
            print("and 'e' is pronounced like the e in 'Engulf'.")
            print("\n- to search by entry, type into prompt (e.g. Zo, Va)")
            print("\n- beware that the entry search function is case sensitive,")
            print("whilst the content search one isn't.")
        elseif (inp2[1] == "helpg" or inp2[1] == "?g") and #inp2 == 1 then
            print([[

DEPRECATED : ASK HABSIEG FOR INFO
]])
        elseif (inp2[1] == "clear" or inp2[1] == "cls") and #inp2 == 1 then
            os.execute("cls")
        elseif (inp2[1] == "ter" or inp2[1] == "x") and #inp2 == 1 then
            break
        elseif (inp2[1] == "read" or inp2[1] == "r") and #inp2 == 1 then --------------------------- Read
    
            local filer = io.open(file, "r")
            if filer ~= nil then
                print("\n[[ CONTENTS ]]\n")
                local num = 1
                for i in io.lines(file) do
                    local temp = {}
                    for j in string.gmatch(i, "([^:]+)") do
                        table.insert(temp, j)
                    end
                    print(num..".\t"..temp[1].." : ".. temp[2])
                    --print(num)
                    num = num + 1
                end
                io.write("\n")
                filer:close()
            end
    
        elseif (inp2[1] == "add" or inp2[1] == "+") and #inp2 == 2 then --------------------------- Add
    
            local t = inp2[2]
            
            local list = {}
            for i in string.gmatch(t, "%S+") do
                table.insert(list, i)
            end
            local add_w = list[1]
    
            local occ = false
            for i in io.lines(file) do
                if i:sub(1, #add_w+1) == add_w..":" then
                    occ = true
                end
            end
            if occ == false then
                io.write(">> ")
                local c = io.read()
    
                local filew = io.open(file, "a")
                if filew ~= nil then
                    filew:write(add_w..":"..c.."\n")
                    filew:close()
                end
            else
                print("entry occupied")
            end
    
        elseif (inp2[1] == "rem" or inp2[1] == "-") and #inp2 == 2 then --------------------------- Remove
            local lines = {}
        
            for line in io.lines(file) do
                if line:sub(1, #inp2[2]+1) ~= inp2[2]..":" then
                    table.insert(lines, line)
                else
                    print("removed entry")
                end
            end
            local f = io.open(file, "w")
            if f ~= nil then
                for _, line in ipairs(lines) do
                    f:write(line .. "\n")
                end
                f:close()
            end
        elseif (inp2[1] == "rep" or inp2[1] == "//") and #inp2 == 3 then --------------------------- Replace Title
            if inp2[2] == inp2[3] then print("invalid replace") else
                local tr = false
                local found = false
                local lines = ""
                for i in io.lines(file) do
                    tr = false
                    if i:sub(1, #inp2[2]+1) == inp2[2]..":" then
                        tr = true
                        found = true
                        local newstr = string.gsub(i, "^"..inp2[2], inp2[3])
                        --print(newstr)
                        lines = lines..newstr.."\n"
                    end
                    if tr == false then
                        lines = lines..i.."\n"
                    end
                    --print(i, tr, found)
                end
                if found == false then print("not found") else
                    local filew = io.open(file, "w")
                    if filew ~= nil then
                        filew:write(lines)
                        filew:close()
                    end
                end
            end
        elseif (inp2[1] == "sch" or inp2[1] == "s") and #inp2 == 2 then --------------------------- Search Contents
            local num = 1
            local found = false
            for i in io.lines(file) do
                local p1, p2 = i:match("([^:]+):([^:]+)")
                --print(p1, p2)
                if p2:lower():find(inp2[2]:lower()) then
                    print("found match :", num..".\t"..p1.." : "..p2)
                    found = true
                end
                num = num + 1
            end
            if found == false then print("no matches found") end
        elseif (inp2[1] == "sort" or inp2[1] == "st") and #inp2 == 1 then --------------------------- Sort Alphabetically
            
            local filer = io.open(file, "r")
            if filer ~= nil then
                local temptemp = {}
                for i in io.lines(file) do
                    local temp = {}
                    for j in string.gmatch(i, "([^:]+)") do
                        table.insert(temp, j)
                    end
                    table.insert(temptemp, (temp[1]..":"..temp[2]))
                    --print(num)
                end

                table.sort(temptemp)
                
                local filew = io.open(file, "w")
                if filew ~= nil then
                    filew:write(table.concat(temptemp, "\n").."\n")
                    filew:close()
                end
                
                io.write("\nSorted Entries Aphabatically\n\n")
                filer:close()
            end
        
        elseif #inp2 == 1 then
            local num = 1
            local found = 0
            local tr = false
            for i in io.lines(file) do
                local p1, p2 = i:match("([^:]+):([^:]+)")
                if i:sub(1, #inp2[1]) == inp2[1] then
                    tr = true
                    print(num..".\t"..p1.." : "..p2)
                    found = found + 1
                end
                num = num + 1
            end

            print("\nfound "..found.." entries ("..inp2[1]..")")
        else
            print("invalid1")
        end
    end

end