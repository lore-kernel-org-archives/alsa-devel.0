From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Bug in emu10k1 multichannel support
Date: Thu, 10 Feb 2005 20:33:07 -0500
Message-ID: <1108085587.15438.6.camel@krustophenia.net>
References: <1106091073.24484.60.camel@krustophenia.net>
	 <s5hpt01tler.wl@alsa2.suse.de> <1106970885.3051.88.camel@krustophenia.net>
	 <41FE5838.4060907@glocalnet.net>
	 <1108073865.11177.6.camel@krustophenia.net>
	 <420BEF63.60402@machinehasnoagenda.com>
	 <1108083562.15438.4.camel@krustophenia.net>
	 <420C0BE5.3060008@machinehasnoagenda.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <420C0BE5.3060008@machinehasnoagenda.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Shayne O'Connor <forums@machinehasnoagenda.com>
Cc: Mikael Magnusson <mikaelmagnusson@glocalnet.net>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-02-11 at 12:35 +1100, Shayne O'Connor wrote:
> [mrmachine@localhost alsa-driver]$ patch -p1 <
> ../emu10k1-multichannel-v009.patch
> can't find file to patch at input line 8
> Perhaps you used the wrong -p or --strip option?

Apply the patch from the main alsa directory, not the alsa-driver
directory.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
