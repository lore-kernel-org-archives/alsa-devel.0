From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: porting oss app to alsa
Date: Thu, 30 Jan 2003 10:08:35 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18eGFp-000202-00@sc8-sf-list1.sourceforge.net>
References: <200301300746.43506.ljp@llornkcor.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 30 Jan 2003 07:46:43 MST."
             <200301300746.43506.ljp@llornkcor.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ljp <ljp@llornkcor.com>
Cc: Thierry Vignaud <tvignaud@mandrakesoft.com>, alsa devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>And instead of bothering people with silly questions, 'how do I perform x OSS 
>function", I went looking at the docs. The tutroials are very good, but don't 
>touch upon some of the more compilcated aspects. It seems maybe there is a 
>glossary or something needed for people more familiar with OSS terminology. 
>
>Such as, whats a poll ? The docs state, in a not very clear way, for example, 
>for snd_timer_poll_descriptors, 'gets poll descriptors'.. hmm, ok, whats a 
>poll descriptor? :D

man 2 poll

>Although I am thankful for the docs, I think it might be useful to have a one 
>page doc outlining the OSS calls..

agreed. but who has the time?


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
