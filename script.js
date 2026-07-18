const inp = document.getElementsByClassName("cmd")[0];
const out = document.getElementsByClassName("output")[0];
out.innerHTML = ""

inp.addEventListener("keydown", function(event) {
if (event.key === "Enter") {
  console.log("yes"+inp.value)
  out.innerHTML += inp.value + '\n';
        
    inp.value = "";
  }
})
