From: Weijia Yang <gte733z@prism.gatech.edu>
Subject: Re: [PATCH] cs46xx DAC volume's mechanism rewrite, minor bugfixes
Date: Fri, 15 Nov 2002 19:48:20 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200211151948.20555.gte733z@prism.gatech.edu>
References: <3DCEB5A4.4090600@cucumelo.org> <20021115120255.GA1114@idefix.fvdpol.home.nl> <20021115123318.GA1479@idefix.fvdpol.home.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20021115123318.GA1479@idefix.fvdpol.home.nl>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Frank van de Pol <fvdpol@home.nl>
Cc: Benny Sjostrand <gorm@cucumelo.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Friday 15 November 2002 07:33 am, Frank van de Pol wrote:
> On Fri, Nov 15, 2002 at 01:02:55PM +0100, Frank van de Pol wrote:
> > On Sun, Nov 10, 2002 at 02:56:35PM -0500, Weijia Yang wrote:
> > > Thanks for working on this issue Benny.  I tried out the code but the
> > > bass issues still persists.  As before, unbalancing the left and right
> > > channels brings the bass back.  Thanks
> >
> > Are you suggesting that one of the channels might phase reversed? Do you
> > have any idea if the bass attuniation is stronger at a specific
> > frequency?
>
> I just had a thought after sending previous message.
>
> can you phase reverse one of the channels and let us know the way your
> behaviour changes?
>
> eg. pressing phase-reverse switch on on of the channel strips on your
> mixing desk, or changing polarity at one of the speaker cables.
>
> Does the 'lack of bass' phenomena exists for data played through the pcm
> (wav, mp3 etc.) or also for analog sources (eg. CDROM audio, line input)?
>
> Frank.

Hmm...I'd like to check this out, but my experience w/ sound apps is very 
lacking.  What program can I use to do what you are talking about? Thanks

Weijia


-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
