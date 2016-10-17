From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: rt5640: enable MCLK detection
Date: Mon, 17 Oct 2016 12:49:41 +0200
Message-ID: <b6427164-56a0-acdf-438a-f0b339016e23@metafoo.de>
References: <1476699970-16751-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id DC235266A34
 for <alsa-devel@alsa-project.org>; Mon, 17 Oct 2016 12:49:49 +0200 (CEST)
In-Reply-To: <1476699970-16751-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, shumingf@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

On 10/17/2016 12:26 PM, Bard Liao wrote:
> Enable MCLK detection.

The commit message can be a bit improved. It should explain what MCLK
detection is and why it should be enabled and what the advantages of that are.
