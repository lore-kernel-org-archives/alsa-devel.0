From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: ALSA + jack + xrun = kernel crash
Date: Wed, 21 May 2003 21:20:37 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19Ieef-0004b3-00@sc8-sf-list1.sourceforge.net>
References: <200305220950.59394.lists@n12turbo.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 22 May 2003 09:50:59 +1000."
             <200305220950.59394.lists@n12turbo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Tarragon Allen <lists@n12turbo.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Just a longshot, and forgive me if it's already been raised : you aren't using
> 
>ext3 by any chance? There are issues with kernel 2.4.20, ext3 which can cause 
>lockups when being used to hard disk recording : this has been shown up while 
>using Ardour. I don't know if it relates, but thought it might help.

i haven't tried the latest CVS, but the lockups with recent CVS affect
me and my system has nothing but ext2.


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
