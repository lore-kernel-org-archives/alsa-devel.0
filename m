From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: spi codec names in machine drivers
Date: Thu, 31 Mar 2011 09:11:19 +0900
Message-ID: <20110331001118.GC21487@opensource.wolfsonmicro.com>
References: <AANLkTi=Vtzxu5pzaActNXc0J1ssbS1djrTfbKnBd3Gq=@mail.gmail.com>
	<20110330212016.GC20496@opensource.wolfsonmicro.com>
	<AANLkTimiKSZDF9jUntoEn1JLHk0a6N+M_U9JvOLcox_a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EDC09103A02
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Mar 2011 02:11:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTimiKSZDF9jUntoEn1JLHk0a6N+M_U9JvOLcox_a@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 30, 2011 at 05:58:29PM -0400, Mike Frysinger wrote:

> so you'd want the machine driver to use "spi0.5" ?  or "ad193x-spi0.5" ?

The latter, I guess.
