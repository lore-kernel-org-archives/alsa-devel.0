From: Dan Malek <dan@embeddedalley.com>
Subject: Re: RFC: OSS driver removal, a slightly different approach
Date: Mon, 23 Jan 2006 09:11:50 -0500
Message-ID: <2edd3641fe1cb18d25e35abe40de5d4e@embeddedalley.com>
References: <20060119174600.GT19398@stusta.de> <20060121210511.GD3456@linux-mips.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp104.biz.mail.re2.yahoo.com (smtp104.biz.mail.re2.yahoo.com [206.190.52.173])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 0C3D4AC
	for <alsa-devel@alsa-project.org>; Mon, 23 Jan 2006 15:11:52 +0100 (MET)
In-Reply-To: <20060121210511.GD3456@linux-mips.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Adrian Bunk <bunk@stusta.de>, perex@suse.cz, linux-mips@linux-mips.org
List-Id: alsa-devel@alsa-project.org


On Jan 21, 2006, at 4:05 PM, Ralf Baechle wrote:

> On Thu, Jan 19, 2006 at 06:46:00PM +0100, Adrian Bunk wrote:
>
>> 3. no ALSA drivers for the same hardware
> [...]
>> SOUND_AU1550_AC97

The Au1550 should have an ALSA driver.  It was done
some time ago.  Perhaps we just didn't submit it to the
proper maintainer.  I'll track that down.

	-- Dan



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
