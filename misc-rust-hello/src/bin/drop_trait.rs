struct CustomSmartPointer {
    data: String,
}

impl Drop for CustomSmartPointer {
    fn drop(&mut self) {
        println!("Dropping CustomSmartPointer with data `{}`!", self.data);
    }
}

fn main() {
    let c = CustomSmartPointer {
        data: String::from("my stuff"),
    };
    let d = CustomSmartPointer {
        data: String::from("other stuff"),
    };
    println!("CustomSmartPointer created.");
    let d = CustomSmartPointer {
        data: String::from("some data"),
    };
    println!("CustomSmartPointer some created.");
    std::mem::drop(d);
    println!("CustomSmartPointer some dropped before the end of main.");
}
