From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: dsnoop
Date: Fri, 16 May 2003 17:24:22 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19Gmd1-00018k-00@sc8-sf-list1.sourceforge.net>
References: <1053116648.423.11.camel@localhost>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "16 May 2003 16:24:08 EDT."
             <1053116648.423.11.camel@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "David E. Storey" <dave@tamos.net>
Cc: alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>Would anyone be so kind as to offer up an example of using dsnoop? I'd
>like to use jack to perform all kinds on monitoring on a device and use
>an alsa app, namely arecord, to do the actual recording. I've tried
>using the jack plugin and while it works, when I hit CTRL-C on arecord
>to stop recording, it pretty much halts jack.

just as a matter of interest, why not use the jack capture client?


-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
