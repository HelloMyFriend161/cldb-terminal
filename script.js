const inp = document.getElementsByClassName("cmd")[0];
const out = document.getElementsByClassName("output")[0];
out.innerHTML = ""

async function readGitHubFile() {
  try {
    const response = await fetch("https://github.com/HelloMyFriend161/cldb-terminal/blob/main/dict.txt");
                
    if (!response.ok) {
      throw new Error(`HTTP error! Status: ${response.status}`);
    }
                
    const text = await response.text();
                
    out.innerHTML = text;
  } catch (error) {
    console.error('Error fetching file:', error);
  }
}

inp.addEventListener("keydown", function(event) {
  if (event.key === "Enter") {
    console.log("yes"+inp.value)
    out.innerHTML += inp.value + '\n';
    //out.innerHTML = readGitHubFile();
    readGitHubFile();

    inp.value = "";
  }
})
