From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoc: wm8731: add 32bit mode.
Date: Fri, 17 Jun 2016 09:19:55 +0100
Message-ID: <20160617081955.GD1552@localhost.localdomain>
References: <1466138896-19739-1-git-send-email-flatmax@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 7433D260560
 for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2016 10:19:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1466138896-19739-1-git-send-email-flatmax@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Flax <flatmax@flatmax.org>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 17, 2016 at 02:48:16PM +1000, Matt Flax wrote:
> This patch adds 32 bit word capability to the wm8731 driver. The wm8731
> codec is capable of handling 32 bit word sizes, however that has not
> previously been activated in the codec driver.
> 
> Signed-off-by: Matt Flax <flatmax@flatmax.org>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
