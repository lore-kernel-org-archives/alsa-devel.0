From: Hans de Goede <hdegoede@redhat.com>
Subject: [RFC 0/2] conf/ucm: bytcht-es8316 support
Date: Thu,  3 Jan 2019 14:50:13 +0100
Message-ID: <20190103135015.14669-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 514B5267BD4
 for <alsa-devel@alsa-project.org>; Thu,  3 Jan 2019 14:50:18 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, Hans de Goede <hdegoede@redhat.com>, linux@endlessm.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Daniel Drake <drake@endlessm.com>
List-Id: alsa-devel@alsa-project.org

Hi All,

Here is the UCM profile to match the kernel patches which I just submitted
upstream. Note this series is RFC for now, since it depends on the name
of a few controls added by the kernel series, as well as on the long_name
set by the kernel series.

Once the kernel series has been merged into -next, this UCM profile series
can be merged as well. I will send another mail when the kernel series has
been accepted.

Regards,

Hans
