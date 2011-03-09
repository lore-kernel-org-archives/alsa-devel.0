From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/6] ASoC: Manage mode and rate bits
 correctly for CS4271 CODEC.
Date: Wed, 9 Mar 2011 13:09:12 +0000
Message-ID: <20110309130912.GA30257@opensource.wolfsonmicro.com>
References: <1299518985.2255.66.camel@r60e>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0DEE82437F
	for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2011 14:08:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1299518985.2255.66.camel@r60e>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alexander Sverdlin <subaparts@yandex.ru>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 07, 2011 at 08:29:45PM +0300, Alexander Sverdlin wrote:
> From: Alexander Sverdlin <subaparts@yandex.ru>
> 
> Manage mode and rate bits correctly, according to datasheet in CS4271 CODEC.
> This is done to make capture work properly.
> 
> Signed-off-by: Alexander Sverdlin <subaparts@yandex.ru>

Applied the rest of these now, thanks.
