From: "Alex Lau" <lau2468@hotmail.com>
Subject: Select call  with alsa
Date: Tue, 06 Jan 2004 23:30:41 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Law10-F77UPMUdjhexa0003b7a3@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I had done some search on the internet about using select(2) with alsa and 
found the function
snd_pcm_file_descriptor( *snd_pcm_handle_t).
However when I try to test it with a simple program, I got compliation error 
of fundefined reference.
I also try to lokk it up in the library documentation buit from the source 
code but unable to find such function.

Can someone direct me to a suitable document about this function?

ps. I am using 1.0.0rc2 version

Thanks in advance.


Alex

_________________________________________________________________
Help STOP SPAM with the new MSN 8 and get 2 months FREE*   
http://join.msn.com/?page=dept/bcomm&pgmarket=en-ca&RU=http%3a%2f%2fjoin.msn.com%2f%3fpage%3dmisc%2fspecialoffers%26pgmarket%3den-ca



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
