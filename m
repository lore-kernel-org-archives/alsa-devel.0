From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1/2] ALSA: soundcore: coding style fixes
Date: Thu, 05 Jun 2014 22:37:57 +0900
Message-ID: <539072B5.5090308@sakamocchi.jp>
References: <1401970346-9043-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id D2E262650F0
 for <alsa-devel@alsa-project.org>; Thu,  5 Jun 2014 15:38:03 +0200 (CEST)
In-Reply-To: <1401970346-9043-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

(Jun 5 2014 21:12), Daniel Mack wrote:
> sound/sounc_core.c has a larger number of style issues. Fix them to make the
> code more readable. No functional change.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
>  sound/sound_core.c | 192 ++++++++++++++++++++++++-----------------------------
>  1 file changed, 85 insertions(+), 107 deletions(-)

Reviewd-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
