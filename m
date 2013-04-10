From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-cvslog] [ALSA GIT]ALSA utilities repository
 branch master updated. v1.0.26-26-ge05b903
Date: Wed, 10 Apr 2013 08:32:05 +0200
Message-ID: <51650765.80900@ladisch.de>
References: <20130408125154.6264F2651CD@alsa0.perex.cz>
 <s5hbo9nyipb.wl%tiwai@suse.de> <51643937.5020602@perex.cz>
 <s5hhajfwuo8.wl%tiwai@suse.de> <516474E7.1030501@canonical.com>
 <s5h4nfe29xa.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id DD5B3262606
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2013 08:32:08 +0200 (CEST)
In-Reply-To: <s5h4nfe29xa.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> I wonder what about other OS.  Is the mixer status of a USB device
> recorded and resumed after reboot at hotplug?

(Some?) drivers save changed control values to the registry.


Regards,
Clemens
