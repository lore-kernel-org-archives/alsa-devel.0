From: Paul Davis <pbd@op.net>
Subject: Re: Please remove documentation pointer
Date: Mon, 15 Jul 2002 13:27:00 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17U9bY-0005tC-00@usw-sf-list1.sourceforge.net>
References: <Pine.HPP.3.96.1020715113852.10952B-100000@hpux15.hrz.uni-oldenburg.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Mon, 15 Jul 2002 12:04:06 +0200."
             <Pine.HPP.3.96.1020715113852.10952B-100000@hpux15.hrz.uni-oldenburg.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Tobias Peters <tpeters@uni-oldenburg.de>
Cc: alsa-devel@lists.sourceforge.net, webmaster@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>This link is labled "Howto use the ALSA API", and it points to
>"http://www.op.net/~pbd/alsa-audio.html". The example programs presented
>there do not work with the current alsa library. This link should at
>least be moved out of section "ALSA 0.9.x Developer documentation". It's
>quite confusing as it is now.

I removed the "minimal full duplex example". The other 3 examples now
contain working (though not useful) code.

>The only existing documentation on how to do full duplex audio
>applications that I found seems to be the C source code of the jack audio
>server. 

ecasound probably has an example too, and perhaps GLAME. 

the reader of my document is referred to JACK, not so much as an
example, but as an alternative to messing around with the ALSA model
and API.

--p


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
