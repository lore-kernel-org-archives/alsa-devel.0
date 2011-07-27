From: Philippe =?iso-8859-15?q?R=E9tornaz?= <philippe.retornaz@epfl.ch>
Subject: Re: [RFC PATCH] ARM ASoC: add sound driver for imx27pdk using mc13783
	codec
Date: Wed, 27 Jul 2011 10:28:09 +0200
Message-ID: <201107271028.09928.philippe.retornaz@epfl.ch>
References: <1310131491-625-1-git-send-email-J.Lambrecht@televic.com>
	<201107081611.25998.philippe.retornaz@epfl.ch>
	<4E1711EA.5070209@televic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4E1711EA.5070209@televic.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lambrecht =?iso-8859-15?q?J=FCrgen?= <J.Lambrecht@televic.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, =?iso-8859-15?q?J=FCrgen_Lambrecht?= <juergen.lambrecht@gmail.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Hi

Le vendredi 8 juillet 2011 16:19:22, Lambrecht J=FCrgen a =E9crit :
> indeed, doesn't work at all. I know it used to work on 2.6.34.
> We also have a fsl linux 2.6.22 were it works.
> I must say: when i use aplay to play a mono file, then there is no
> error, it just never ends, and no sound also.
> For a stereo file, it gives the error.
> Mark also that when I use madplay (v0.15.2) (or mp3play) to play a mono
> or stereo mp3, it allocates 3 DMA channels, but only frees one after the
> error.
> =


Did you made any progress on this ? =


Regards,

Philippe
