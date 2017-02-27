From: Bryce Ferguson <bryce.ferguson@rockwellcollins.com>
Subject: Re: [PATCH 1/1] ASoC: Add AU1761 audio codec as
	selectable option
Date: Mon, 27 Feb 2017 08:20:40 -0600
Message-ID: <CAKGmAFpCZ_2Mo9Eqcj97qds4EgmY5poAbqiXw8CfVnebMubTeg@mail.gmail.com>
References: <1488205062-3265-1-git-send-email-bryce.ferguson@rockwellcollins.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch3vs02.rockwellcollins.com (ch3vs02.rockwellcollins.com
 [205.175.226.29])
 by alsa0.perex.cz (Postfix) with ESMTP id EB357266C1E
 for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2017 15:20:42 +0100 (CET)
Received: by mail-yw0-f199.google.com with SMTP id 2so133881202ywn.1
 for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2017 06:20:41 -0800 (PST)
In-Reply-To: <1488205062-3265-1-git-send-email-bryce.ferguson@rockwellcollins.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, girdwood@gmail.com
Cc: Bryce Ferguson <bryce.ferguson@rockwellcollins.com>, alsa-devel@alsa-project.org, patch@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

On Mon, Feb 27, 2017 at 8:17 AM, Bryce Ferguson
<bryce.ferguson@rockwellcollins.com> wrote:
> This commit adds the ADI AU1761 audio codec as a selectable option
> in the kernel config.  Currently the driver can only be selected
> for ADI blackfin devices or if SND_SOC_ALL_CODECS is enabled.
>
> Signed-off-by: Bryce Ferguson <bryce.ferguson@rockwellcollins.com>
>

I must have messed up the email the first time around so it shows up
as a new submission here, but this patch has been acked. (Here's a
link https://patchwork.kernel.org/patch/9591995/)
Thanks, sorry for any confusion.

-Bryce
