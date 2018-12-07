From: <twischer@de.adit-jv.com>
Subject: [PATCH - extplug without conversion 0/1] pcm: extplug:
	Use same format for slave
Date: Fri, 7 Dec 2018 17:12:12 +0100
Message-ID: <1544199133-15051-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
 by alsa0.perex.cz (Postfix) with ESMTP id D77D5267D0C
 for <alsa-devel@alsa-project.org>; Fri,  7 Dec 2018 17:12:26 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

I have the following new idea for
[PATCH - extplug refinement from hw_params 1/1] pcm: extplug: Update slave PCM if extplug slave params were changed

May be you could give a short feedback.
I will try to provide a reproduction scenario.

Do you have an idea how to handle this additional function parameter without breaking the API.

Best regards
Timo
