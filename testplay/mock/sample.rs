fn say_hello(content: &str) {
    if content.is_empty() {
        println!("...");
    } else {
        println!("{}", content);
    }
}

fn main() {
    say_hello("");
    say_hello("Hi");

    let obj = std::collections::HashMap::from([
        ("foo", "bar"),
        ("hoge", "fuga"),
    ]);
    println!("{:?}", obj);

    let nums = vec![1, 2, 3];
    for n in &nums {
        println!("{}", n);
    }
}
