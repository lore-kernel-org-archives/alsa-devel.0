From: James Stafford <alsa@jjdstaff.demon.co.uk>
Subject: Re: Envy24HT
Date: Wed, 27 Nov 2002 21:47:01 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <5.1.0.14.0.20021127214603.028068e0@pop3.demon.co.uk>
References: <5.1.0.14.0.20021124201637.01e62910@pop3.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0211251302570.517-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

At 12:06 25/11/02, you wrote:
>On Sun, 24 Nov 2002, James Stafford wrote:
>
> > Has anyone started work on a driver for the VIA VT1724 (alias Envy24HT)?
> >
> > The company I work for are planning to release a PC104+ card based on
> > this chipset (paired with the VT1616) in the very near future so I have
> > access to one of the evaluation kits from VIA.
> >
> > If noone else is working on a driver, I may be able to persuade my boss
> > to allow me to work on it. However, my knowledge of the architecture of
> > this chip and audio hardware in general is currently quite limited.
>
>It's possible to add the support to the ICE1712 driver for this new chip,
>but it's difficult without hardware.

I have now modified the ICE1712 driver downloaded from the CVS on 26th 
November to add basic support for the Envy24HT.
I will tidy the code up and hopefully send a patch by the weekend.



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
