From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: CS46xx woes.
Date: Sun, 17 Nov 2002 16:55:41 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DD7BBFD.9040607@cucumelo.org>
References: <20021115121043.67b5c0af.flame@home.se>	<Pine.LNX.4.33L2.0211151339210.14712-100000@cactus> <20021116203320.5828f7dd.flame@home.se>
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
To: Richard Olsson <flame@home.se>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
>
>Heh; I haven't noticed anything bad with it while using Windows, but
>then again I don't set so high standards. ;)
>  
>
It was long a time since I tested this card with Windows, so I really dont
have any good point of comparison.  
Depending of what you are playing sound get's distorcionated when
PCM volume is higher ~75%, dont known it's possible to get it better.
We probably never going to known whatever magic is done in the Windows 
driver.

>Hmm; with rc2 if I unmute the cd input the amplifier seems to get
>disabled sometimes (thus resulting in very badly disorted sound), but
>using latest CVS nothing happens.
>
OK. confirmed, thanks for testing it out.

/Benny



-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
