From: Mark Rages <markrages@mlug.missouri.edu>
Subject: Re: [Alsa-user] Gadget labs: is there a alsa-driver that will work with it?
Date: Mon, 22 Apr 2002 22:19:33 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020422221933.A32287@mlug.missouri.edu>
References: <Pine.A41.4.40.0204222108520.30726-100000@orion.it.luc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.A41.4.40.0204222108520.30726-100000@orion.it.luc.edu>; from mkhemma@orion.it.luc.edu on Mon, Apr 22, 2002 at 09:16:50PM -0500
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Mark Khemma <mkhemma@orion.it.luc.edu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Mark,

I have wated to write a driver for these cards for a long time. I have
written enough code for my GL Wave/4 to play a sinewave. I think there is
trouble in the ISA-PNP section though.

There is no official support, but there is some leaked source code
available that should get us on the right direction.

I have some resources here:

http://mark.rages.net/index.php?GadgetLabs

I follow the GL-users mailing list. Low signal-to-noise ratio there,
however.

Mark Rages

On Mon, Apr 22, 2002 at 09:16:50PM -0500, Mark Khemma wrote:
> 
> helllooo,
> i have in my hands a gadget labs soundcard, the 824 to be precise and i'm
> wondering if anyone has any information about this card. i'm looking at it
> and it there is a couple ensoniq chips and a single motarola chip on the
> board, though i don't know the exact model. And there is a "SoundPort"
> chip on it as well. The board itself is made by ensoniq. Its just been
> sitting in my closet for the past year, and now i'm wondering if i can
> make use of it. Any information would be great. I'm curious if anybody has
> got the detailed specs on this piece. I"m might just plug this thing in
> and see if alsaconf will recognize it. And if there is more information
> that i can gather i might just try to learn how to develop a module for
> this thing, hehe.
> -mark
> 
> 
> _______________________________________________
> Alsa-user mailing list
> Alsa-user@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-user
