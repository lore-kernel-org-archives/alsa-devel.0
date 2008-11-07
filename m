From: "Sebastian Schneider" <Sebastian.Brian@gmx.de>
Subject: Re: Creative Sound Blaster X-Fi and X-Fi
 Titanium	Series Linux 32bit/64bit Driver Source released
Date: Sat, 08 Nov 2008 00:28:57 +0100
Message-ID: <20081107232857.307130@gmx.net>
References: <5501535d0811060746y60d18e6boc8c5ad34a63fb92b@mail.gmail.com>
	<8fe68c970811061536n52c6c819v58145401002555be@mail.gmail.com>
	<4913C742.9040107@gmail.com>
	<5501535d0811071108u7e922704h97408525e670741@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 76764103826
	for <alsa-devel@alsa-project.org>; Sat,  8 Nov 2008 00:28:58 +0100 (CET)
In-Reply-To: <5501535d0811071108u7e922704h97408525e670741@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

At least it is working with you. Amarok, mplayer, xine and all other players tell me that there is no sounddevice found. The driver is compiled on 2.6.27 installation went successful, the driver was also loaded without problems.

-------- Original-Nachricht --------
> Datum: Fri, 7 Nov 2008 20:08:50 +0100
> Von: "Bjoern Olausson" <lkmlist@gmail.com>
> An: "The Source" <thesourcehim@gmail.com>
> CC: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
> Betreff: Re: [alsa-devel] Creative Sound Blaster X-Fi and X-Fi Titanium	Series Linux 32bit/64bit Driver Source released

> On Fri, Nov 7, 2008 at 05:42, The Source <thesourcehim@gmail.com> wrote:
> 
> > It was incompatibility with older kernels. Updated to 2.6.27 and driver
> > works now. But no 5.1 support again :(
> >
> 
> speaker-test -c 6 at least plays sound on Front-Left, Center and
> Front-Right.
> 
> No sound on the rear speakers or on the Subwoofer....
> 
> But hey, it's half the way...
> 
> kind regards
> Bjoern
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
"Feel free" - 5 GB Mailbox, 50 FreeSMS/Monat ...
Jetzt GMX ProMail testen: http://www.gmx.net/de/go/promail
