From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: pxa: Convert poodle to use
 snd_soc_register_card()
Date: Fri, 30 Dec 2011 02:00:42 +0000
Message-ID: <20111230020041.GC9737@opensource.wolfsonmicro.com>
References: <1325207771.9599.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1F6D2103A9D
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2011 03:00:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1325207771.9599.1.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Eric Miao <eric.y.miao@gmail.com>, linux-kernel@vger.kernel.org, Haojian Zhuang <haojian.zhuang@marvell.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 30, 2011 at 09:16:11AM +0800, Axel Lin wrote:
> Use snd_soc_register_card() instead of creating a "soc-audio" platform device.

Applied all, thanks.
