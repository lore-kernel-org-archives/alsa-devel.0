From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: Re.  [PATCH] cs46xx: SPDIF channel status more volume
 fixes
Date: Sat, 16 Nov 2002 12:51:36 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DD63148.2000802@cucumelo.org>
References: <1037411161.9365.0.camel@pete>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Good <psgood@petesinternet.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
>
>This hasn't made it into CVS yet I take it? If so (forgive me for being
>a newbie to this thing hehe.), but syntax to apply the patch to my
>source?
>  
>
Stand in the 'alsa-kernel' directory and type:
$ patch -p1 < cs46xx.patch

(and hopefully you got no complains from the patch program)

/Benny



-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
