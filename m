From: =?iso-8859-15?Q?Lothar_Wa=DFmann?= <LW@KARO-electronics.de>
Subject: Re: [RFC PATCH v2 1/3] ep93xx i2s audio driver
Date: Wed, 26 May 2010 15:08:26 +0200
Message-ID: <19453.7498.815423.705243@ipc1.ka-ro>
References: <1274850588-30460-1-git-send-email-ryan@bluewatersys.com>
	<1274850588-30460-2-git-send-email-ryan@bluewatersys.com>
	<1274878490.9346.38.camel@cndougla-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1274878490.9346.38.camel@cndougla-ubuntu>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chase Douglas <chasedouglas@gmail.com>
Cc: john.cooper@third-harmonic.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, Ryan Mallon <ryan@bluewatersys.com>, linux-arm-kernel@lists.infradead.org, r&d4@dave-tech.it, hartleys@visionengravers.com, lrg@slimlogic.co.uk, buytenh@wantstofly.org, dhuggins@cs.cmu.edu
List-Id: alsa-devel@alsa-project.org

Hi,

> > +#define EP93XX_I2S_LRDIV	17
> > +#define EP93XX_I2S_SDIV		16
> =

> Looks like a minor ugly whitespace issue above.
> =

Only in the indentation of the patch...
If you look at the code with the leading '+' removed, indentation is
OK.


Lothar Wa=DFmann
-- =

___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=DFe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=E4ftsf=FChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
