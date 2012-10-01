From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Revert 'ASoC: imx-ssi: Remove mono
	support'
Date: Mon, 1 Oct 2012 13:20:34 +0100
Message-ID: <20121001122034.GM4360@opensource.wolfsonmicro.com>
References: <1346891410-4379-1-git-send-email-festevam@gmail.com>
 <20120906004427.GW10580@opensource.wolfsonmicro.com>
 <CACKLOr3VDxDQb30aqNOhEHtc7AAFUZw07_BAwrk3yXqmBfHyxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1D368261724
 for <alsa-devel@alsa-project.org>; Mon,  1 Oct 2012 14:20:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CACKLOr3VDxDQb30aqNOhEHtc7AAFUZw07_BAwrk3yXqmBfHyxQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: javier Martin <javier.martin@vista-silicon.com>
Cc: alsa-devel@alsa-project.org, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 01, 2012 at 11:33:45AM +0200, javier Martin wrote:
> Hi Mark, Fabio,
> this patch should be applied as a fix to stable 3.6 too. Otherwise,
> audio for Visstrim M10 will continue broken in 3.6.

You need to tell the stable team about this, then.
