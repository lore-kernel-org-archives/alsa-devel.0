From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: RFC: OSS driver removal, a slightly different approach
Date: Sat, 21 Jan 2006 21:05:11 +0000
Message-ID: <20060121210511.GD3456@linux-mips.org>
References: <20060119174600.GT19398@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id ED716169
	for <alsa-devel@alsa-project.org>; Mon, 23 Jan 2006 13:28:28 +0100 (MET)
Received: from bacchus.net.dhis.org (unknown [194.74.144.146])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id 13A609923F
	for <alsa-devel@alsa-project.org>; Mon, 23 Jan 2006 13:28:26 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <20060119174600.GT19398@stusta.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@suse.cz, linux-mips@linux-mips.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 19, 2006 at 06:46:00PM +0100, Adrian Bunk wrote:

> 3. no ALSA drivers for the same hardware
[...]
> SOUND_AU1550_AC97
[...]
> SOUND_IT8172
[...]
> SOUND_VRC5477

I'm already hammering the responsible people to rewrite the drivers for
ALSA since a while but slow progress.  The latter two platforms have no
active maintainers so I don't expect to see ALSA drivers.

  Ralf


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
