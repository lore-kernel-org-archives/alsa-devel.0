From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tlv320aic32x4: Use
 snd_soc_dapm_context as required
Date: Mon, 7 Mar 2011 10:37:03 +0000
Message-ID: <20110307103703.GA13471@opensource.wolfsonmicro.com>
References: <1299493929-849-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BFEA3103818
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2011 11:37:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1299493929-849-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Javier Martin <javier.martin@vista-silicon.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 07, 2011 at 10:32:09AM +0000, Dimitris Papastamos wrote:
> Fix compilation issues by using the snd_soc_dapm_context pointer
> whenever it is required.
> 
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>

I've already done this locally.
