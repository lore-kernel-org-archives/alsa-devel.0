From: Andrew Gaydenko <a@etver.com>
Subject: Re: build error in pcm_native.c
Date: Fri, 16 Jul 2004 13:56:54 +0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200407161356.54551@goldspace.net>
References: <200407152209.21287@goldspace.net> <200407161325.45484@goldspace.net> <s5hpt6w70c6.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hpt6w70c6.wl@alsa2.suse.de>
Content-Disposition: inline
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

I have updated all the alsa CVS tree (. CVS dir). Yesterday there was some updating
of the file under problem.

Andrew

======= On Friday 16 July 2004 13:44, Takashi Iwai wrote: =======
At Fri, 16 Jul 2004 13:25:45 +0400,
Andrew Gaydenko wrote:
> 
> Takashi, yes I did. 

And did you update both alsa-driver and alsa-kernel trees?
The configure script was changed to detect the old remap_page_range().


Takashi

> 
> Andrew
> ======= On Friday 16 July 2004 13:22, you wrote: =======
> At Thu, 15 Jul 2004 22:09:21 +0400,
> Andrew Gaydenko wrote:
> > 
> > Hi,
> > 
> > Have tried to build drivers from current CVS and have got an error shown below.
> > Must I supply some additional info?
> 
> Did you run cvscompile?
> 
> 
> Takashi
> 
> 


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
