//
// Basic Interface
//
function get_messages(thread_id, message_id){
	//
	let thread_name = "thread_" + thread_id + "_" + message_id;
	let current_messages = localStorage.getItem(thread_name);
	console.log(current_messages)
	return current_messages;
}
function set_messages(thread_id, message_id, message){
	//
	let thread_name = "thread_" + thread_id + "_" + message_id;
	localStorage.setItem(thread_name, message);
}
function set_thread_sender(thread_id){
	// 
	let sender_name = "threadsender_" + thread_id;
	localStorage.setItem(sender_name, "2");
}
function current_messages_in_thread(thread_id){
	// 
	let half_thread_name = "thread_" + thread_id;
	let thread_keys = Object.keys(localStorage);
	let thread_key_name;
	let half_thread_name_length = half_thread_name.length;
	let message_ids  = []
	for(var i = 0; i < thread_keys.length; i++ ){
		thread_key_name = thread_keys[i];
		if ( thread_key_name.slice(0, half_thread_name_length) == half_thread_name ){
			let message_id = parseInt(thread_key_name.slice(half_thread_name_length+1));
			message_ids.push(message_id);
		}
	}
	message_ids = message_ids.sort();
	return message_ids
}
function current_threads(){
	//
	let thread_keys  = Object.keys(localStorage);
	let thread_head  = "thread_";
	let threadsender_head = "threadsender_";
	let thread_value = "";
	let message_ids  = [];
	let thread_id    = 0;  let thread_ids = [];
	for(var i = 0; i < thread_keys.length; i++ ){
		thread_value = thread_keys[i].replace(thread_head, "");
		message_ids  = thread_value.split("_");
		thread_id    = parseInt(message_ids[0]);
		if ( thread_keys[i].slice(0, 13) == threadsender_head ) {
			// 
		} else if ( thread_ids.indexOf(thread_id) == -1 ) {
			thread_ids.push(thread_id);
		}
	}
	thread_ids = thread_ids.sort();
	return thread_ids
}
// 
function generate_message(thread_id, message){
	// 
	let current_thread   = current_messages_in_thread(thread_id);
	let latest_thread_id = current_thread.sort()[current_thread.length-1];
	if ( !latest_thread_id ) {
		latest_thread_id = 1;
	} else {
		latest_thread_id += 1;
	}
	set_messages(thread_id, latest_thread_id, message);
}
function generate_thread(first_message){
	//
	var c_threads  		 = current_threads();
	let latest_thread_id = c_threads.sort()[c_threads.length-1] + 1;
	generate_message(latest_thread_id, first_message);
	set_thread_sender(latest_thread_id);
	generate_sender(latest_thread_id+1, "2");
}
function generate_sender(thread_id, is_myself){
	//
	let sender_name 	 = "threadsender_" + thread_id;
	let sender_content	 = localStorage.getItem(sender_name);
	if ( !sender_content ) {
		//
	} else if ( sender_content == "," ) {
		//
		localStorage.setItem(sender_name, is_myself);
	} else {
		//
		let updated_sender_content = sender_content + "," + is_myself;
		localStorage.setItem(sender_name, updated_sender_content);
	}
}
// function delete_thread(thread_id){
// 	//
// 	let thread_name 		 = "thread_" + thread_id;
// 	let threadsender_name 	 = "threadsender_" + thread_id;
// 	let thread_keys  		 = Object.keys(localStorage);
// 	for(var i = 0; i < thread_keys.length; i++ ){
// 		let each_thread_name = thread_keys[i];
// 		let thread_key_length = String(i).length + 7; // important to remind not to forget checking 10 ~ 99 length
// 		let sender_key_length = String(i).length + 13;
// 		if ( each_thread_name.slice(0, thread_key_length) == thread_name ) {
// 			localStorage.removeItem(each_thread_name);
// 		}
// 		if ( each_thread_name.slice(0, sender_key_length) == threadsender_name ) {
// 			localStorage.removeItem(each_thread_name);
// 		}
// 	}
// }

// get messages
function get_messages(thread_id){
	let message_ids  = current_messages_in_thread(thread_id);
	let thread_head  = "thread_" + thread_id + "_";
	let thread_value = "";
	let message_content = "";
	let thread_array = [];
	for(var i = 1; i < message_ids.length+1; i++){
		thread_value = thread_head + i;
		message_content = localStorage.getItem(thread_value);
		thread_array.push(message_content);
	}
	return thread_array
}
function get_senders(thread_id){
	let sender_name	 = "threadsender_" + thread_id;
	let sender_content = localStorage.getItem(sender_name);
	let sender_array = sender_content.split(',');
	return sender_array
}

// 
// UI
//
function start_thread(){
	generate_thread("Let's talk with your customers!!!!");
	remove_threads();
	show_threads();
}
function show_threads(){
	let thread_ids 		= current_threads();
	let thread_messages = "";
	var message_html    = "";
	for ( var i = 1;  i < thread_ids.length + 1; i++ ){
		thread_messages = get_messages(i);
		thread_senders  = get_senders(i);
		message_html += "\<div class='col-6 thread-region'\>\<h6\>Thread" + i + "\</h6\>";
		message_html += "\<div class='each-message-region'\>";
		for ( var j = 0; j < thread_messages.length; j++ ) {
			let current_sender = thread_senders[j];
			if ( current_sender == "1" ) {
				message_html += "\<div class='alert alert-primary each-message'\>" + thread_messages[j] + "\</div\>";
			} else if ( current_sender == "0" ) {
				message_html += "\<div class='alert alert-secondary each-message rightside-message'\>" + thread_messages[j] + "\</div\>";
			} else if ( current_sender == "2" ) {
				message_html += "\<div class='alert alert-warning start-message'\>" + thread_messages[j] + "\</div\>";
			}
		}
		message_html += "\</div\>"
		message_html += "\<input type='text' class='form-control message-send-form'\>"
		message_html += "\<a href='javascript:send_message("+ i +")' class='btn btn-primary'\>送信する\</a\>\</div\>";
	}
	console.log(message_html);
	document.getElementsByClassName("message-region")[0].innerHTML = message_html;
}

function remove_threads(){
	let thread_ids 		= current_threads();
	for ( var i = 0;  i < thread_ids.length; i++ ){
		document.getElementsByClassName("thread-region")[i].innerHTML = "";
	}
}

function send_message(thread_id){
	let current_thread_document = document.getElementsByClassName('thread-region')[thread_id-1];
	let message_content = current_thread_document.getElementsByClassName('message-send-form')[0].value;
	if (!message_content == false) {
		generate_message(thread_id, message_content);
		generate_sender(thread_id, "1");
		remove_threads();
		show_threads();
	}
}

//
// PopUp
//
function show_popup(){
	//
	document.getElementsByClassName("popup1")[0].classList.remove("hide-popup");
	document.getElementsByClassName("main-page-content")[0].classList.remove("font-color-black");
	document.getElementsByClassName("main-page-content")[0].classList.add("font-color-white");
}
function hide_popup(){
	//
	document.getElementsByClassName("popup1")[0].classList.add("hide-popup");
	document.getElementsByClassName("main-page-content")[0].classList.remove("font-color-white");
	document.getElementsByClassName("main-page-content")[0].classList.add("font-color-black");
}
document.onkeydown = function(e) {
	console.log("key pressed !!!!!")
	var PressedKeyCode = e.keyCode; // 71
	var ControlBool    = e.ctrlKey; // true
	if ( PressedKeyCode == 77 && ControlBool == true ) {
		show_popup();
	} else if ( PressedKeyCode == 69 && ControlBool == true ) {
		hide_popup();
	}
}


