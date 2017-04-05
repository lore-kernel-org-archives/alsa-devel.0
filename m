From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH 1/2] ASoC: fsl_ssi: Remove an outdated
	comment
Date: Wed, 5 Apr 2017 13:26:38 -0500
Message-ID: <fb6f24af-00c8-0421-32bd-868b28a59989@tabi.org>
References: <1491410411-6053-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id AA4E7266943
 for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2017 20:26:41 +0200 (CEST)
In-Reply-To: <1491410411-6053-1-git-send-email-fabio.estevam@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@nxp.com>, broonie@kernel.org
Cc: nicoleotsuka@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 04/05/2017 11:40 AM, Fabio Estevam wrote:
> Therefore, we tell
> - * ALSA that we support all rates and let the codec driver decide what
> rates
> - * are really supported.

This part is still true, though, isn't it?
