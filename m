From: =?ISO-8859-1?Q?Daniel_Gl=F6ckner?= <dg@emlix.com>
Subject: Re: [PATCH] AsoC/s6000: use resource_size for
 {request/release}_mem_region and ioremap
Date: Wed, 02 Jun 2010 14:35:18 +0200
Message-ID: <4C065006.7030305@emlix.com>
References: <4C063751.2060001@gmail.com>
	<20100602105123.GB3020@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.emlix.com (mx1.emlix.com [193.175.82.87])
	by alsa0.perex.cz (Postfix) with ESMTP id 551362461E
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Jun 2010 14:35:20 +0200 (CEST)
In-Reply-To: <20100602105123.GB3020@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Wan ZongShun <mcuos.com@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Acked-by: Daniel Gl=F6ckner <dg@emlix.com>

On 06/02/2010 12:51 PM, Mark Brown wrote:
> CCing in Daniel who wrote the S6000 support.  Daniel, do you want to add
> an entry to MAINTAINERS for this stuff or are you happy without having
> stuff run past you?

I don't think it is necessary to add an entry to MAINTAINERS.
My name and address listed at the top of the file should be enough.
It's not like I'm still working on it, but if needed I can take the
device from the shelf to perform some tests, should anyone make more
serious changes to the driver.

  Daniel


-- =

Dipl.-Math. Daniel Gl=F6ckner, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax -11, Bahnhofsallee 1b, 37081 G=F6ttingen, Germany
Sitz der Gesellschaft: G=F6ttingen, Amtsgericht G=F6ttingen HR B 3160
Gesch=E4ftsf=FChrer: Dr. Uwe Kracke, Ust-IdNr.: DE 205 198 055

emlix - your embedded linux partner
