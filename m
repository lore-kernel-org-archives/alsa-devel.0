From: Paul Davis <pbd@op.net>
Subject: Re: HDSP -- how to configure modules.conf?
Date: Wed, 15 May 2002 13:27:30 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E1782XI-0008Ho-00@usw-sf-list1.sourceforge.net>
References: <000001c1fc35$26febee0$ac1f830a@ico>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Wed, 15 May 2002 13:22:55 EDT."
             <000001c1fc35$26febee0$ac1f830a@ico>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Ivica Bukvic <ico@fuse.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>> >Do I use snd-rme9652.o module for hdsp or which one?
>> 
>> snd-hdsp.o
>
>Problem is there is no such module that gets compiled. Tried compiling
>on two different boxes with multiple CVS updates and complete nukes.
>
>After installing the whole thing, in the alsa-driver/modules/ there is
>no such module, nor in the /lib/modules/...
>
>Again, has anyone else tried compiling the driver from the CVS and had a
>success?

How did you compile? I mean right from the very beginning ... I've
obviously been building from CVS all along, and I assume that Jaroslav
did a rebuild after he committed the changes.

--p

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
