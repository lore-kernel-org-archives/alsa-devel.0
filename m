From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: emu10k1 driver broken in CVS
Date: Tue, 15 Mar 2005 23:46:50 -0500
Message-ID: <1110948410.19837.0.camel@mindpipe>
References: <1110947679.19739.3.camel@mindpipe>
	 <4237BAA8.3020405@machinehasnoagenda.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <4237BAA8.3020405@machinehasnoagenda.com>
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
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2005-03-16 at 15:48 +1100, Shayne O'Connor wrote:
> after compiling, i tried inserting the alsa modules and got a whole
> bunch of errors ... when rebooting back into xfce4.2, it just froze at
> the splash screen ... had to boot into an earlier kernel and re-install
> the Planet CCRMA alsa modules.

It must be the "Fix corrupted voice allocation" patch or the P16V stuff.
CVS from 2005-3-10 works fine, 2005-3-15 does not.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
