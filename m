From: Adam Goode <agoode@google.com>
Subject: [PATCH v2 - sound/usb 0/2] Respond to suspend and
	resume callbacks for usb midi
Date: Tue,  5 Aug 2014 12:44:49 -0400
Message-ID: <1407257091-16462-1-git-send-email-agoode@google.com>
References: <s5hegwv6rl8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f54.google.com (mail-yh0-f54.google.com
 [209.85.213.54])
 by alsa0.perex.cz (Postfix) with ESMTP id B0321261A29
 for <alsa-devel@alsa-project.org>; Tue,  5 Aug 2014 18:44:56 +0200 (CEST)
Received: by mail-yh0-f54.google.com with SMTP id v1so833000yhn.13
 for <alsa-devel@alsa-project.org>; Tue, 05 Aug 2014 09:44:55 -0700 (PDT)
In-Reply-To: <s5hegwv6rl8.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

This is v2 of the midi input fix. I still need to work on fixing output in the same way,
though it is less serious.

I have a whitespace cleanup patch as well, feel free to ignore.


Thanks,

Adam
