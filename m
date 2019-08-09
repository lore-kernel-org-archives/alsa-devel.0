From: GitHub issues - opened <github@alsa-project.org>
Subject: jack plugin freezes mpv.
Date: Fri,  9 Aug 2019 08:49:55 +0200 (CEST)
Message-ID: <20190809064955.14C8DF803F3@alsa1.perex.cz>
References: <1565333391944293976-webhooks-bot@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id CCCF9F800E4
 for <alsa-devel@alsa-project.org>; Fri,  9 Aug 2019 08:49:52 +0200 (CEST)
In-Reply-To: <1565333391944293976-webhooks-bot@alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

alsa-project/alsa-plugins issue #1 was opened from crocket:

I'm using alsa-plugin-1.1.8

`mpv --audio-device=alsa/plug:rawjack /path/to/musicfile` freezes mpv.
mpv doesn't freeze only when it plays a wav file.
I have to press Ctrl+C twice to kill mpv.

Issue URL     : https://github.com/alsa-project/alsa-plugins/issues/1
Repository URL: https://github.com/alsa-project/alsa-plugins
