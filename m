From: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18: hda_intel: azx_get_response timeout,
 switching to single_cmd mode...
Date: Tue, 26 Sep 2006 09:31:42 -0700
Message-ID: <20060926093142.43369b93.akpm__21165.5606319711$1159288523$gmane$org@osdl.org>
References: <451834D0.40304@goop.org>
	<s5hlko7szjy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 52D32233
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Sep 2006 18:31:48 +0200 (MEST)
In-Reply-To: <s5hlko7szjy.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Pavel Machek <pavel@suse.cz>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 26 Sep 2006 12:16:33 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> You must see difference with mm1 (suppose that mm1 already includes
> the latest ALSA patches).

No, the alsa tree was accidentally omitted from 2.6.18-mm1, sorry.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
