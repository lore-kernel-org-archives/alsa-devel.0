From: "Eugenia Loli-Queru" <eloli@eugenia.co.uk>
Subject: Re: The ALSA Situation
Date: Tue, 9 Nov 2004 18:38:55 -0800
Message-ID: <001e01c4c6ce$77672eb0$0a00000a@eugenia>
References: <200411100150.iAA1okCE029069@localhost.localdomain>
Reply-To: "Eugenia Loli-Queru" <eloli@eugenia.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net, torvalds@osdl.org
List-Id: alsa-devel@alsa-project.org

>. But
> ALSA isn't going anywhere in the direction you and many others need it
> to without some more people *really* getting into the development
> team. No matter how much Jaroslav might agree with all that you've
> said, there are not enough hours in the day (his or yours) to make
> that happen.

Why not move to OSS 4.x to the Linux kernel then (which is afaik actively 
developed), when it's out? If alsa is the failure you are describing, with 
no extra devs working on it, I see absolutely no reason for it to be used as 
default in the kernel and drive more developers to use it instead of OSS 
(and also develop an alsa 1.0.2 wrapper in order to keep compatibility with 
alsa apps so far). Sure, OSS is not GPL, but who cares, if it does the job 
at the end of the day? I for one, only care for things to work as I expect 
them too, I don't care about the politicalities.

BTW, in my previous email, I forgot to mention two more huge problems with 
alsa:
1. again with the mixing thing, browsers will stall and not load a flash 
webpage if another app uses the sound device. It's tragic to see firefox not 
loading www.macromedia.com for example, just because xmms is playing a 
song...
2. This: http://www.osnews.com/img/6443/audio.png Check the clean and 
logical OSS options and then check the endless alsa ones (my monitor was not 
wide enough to fit them all). Why things like that are not cleaned up? (it's 
not gnome's volume control fault btw, I asked the developer, he said it's 
Alsa's)

Rgds,
Eugenia 



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
