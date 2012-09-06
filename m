From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Remove unused 'saved_value' field
 from snd_soc_dapm_widget struct
Date: Thu, 6 Sep 2012 08:09:50 +0800
Message-ID: <20120906000949.GQ10580@opensource.wolfsonmicro.com>
References: <1346661266-21894-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8E6E1264F02
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2012 02:09:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1346661266-21894-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 03, 2012 at 10:34:26AM +0200, Lars-Peter Clausen wrote:
> The only user was removed over two years ago in commit a6c65736 ("ASoC: Remove
> current PGA control handling").

Applied, thanks.
