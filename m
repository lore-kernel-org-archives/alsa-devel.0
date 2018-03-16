From: <twischer@de.adit-jv.com>
Subject: [PATCH - JACK plugin 3/4] jack: Report Xruns to user
	application
Date: Fri, 16 Mar 2018 15:23:31 +0100
Message-ID: <1521210212-30923-1-git-send-email-twischer@de.adit-jv.com>
References: <1519910048-19732-4-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 976DB267503
 for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2018 15:23:41 +0100 (CET)
In-Reply-To: <1519910048-19732-4-git-send-email-twischer@de.adit-jv.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org


Hello all,

I have updated this patch.
It can merged without conflicts, now.
It is no longer requiring an internal state variable.

@Takashi: Thanks for your efforts so far.
Possible it makes sense that you also have a look into this patch.

I would be happy about a feedback.

Best reagards

Timo
