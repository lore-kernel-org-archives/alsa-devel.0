From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Switch palm27x-asoc to jack detection api
Date: Fri, 24 Jul 2009 11:30:03 +0100
Message-ID: <20090724103003.GB28228@rakim.wolfsonmicro.main>
References: <200907232216.56320.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D2ABF103A92
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jul 2009 12:30:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200907232216.56320.marek.vasut@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 23, 2009 at 10:16:56PM +0200, Marek Vasut wrote:
> This patch removes the old method of jack detection from palm27x-asoc
> driver and adds jack detection api. It also removes some other (now)
> useless stuff from the driver and corrects pin configuration for the
> codec.

Applied, thanks.
