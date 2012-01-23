From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add __devinit/__devexit annotations
 at necessary places
Date: Mon, 23 Jan 2012 10:21:40 +0000
Message-ID: <20120123102140.GB2879@opensource.wolfsonmicro.com>
References: <1327288697.14153.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E3E6A24489
	for <alsa-devel@alsa-project.org>; Mon, 23 Jan 2012 11:21:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1327288697.14153.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Andrey Danin <danindrey@mail.ru>, Leon Romanovsky <leon@leon.nu>, Arnaud Patard <arnaud.patard@rtp-net.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 23, 2012 at 11:18:17AM +0800, Axel Lin wrote:
> Fix below build warning when CONFIG_HOTPLUG is not set.

Applied, thanks.
