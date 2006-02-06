From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] hda: ALC260 test model implementation
Date: Mon, 06 Feb 2006 18:26:30 -0500
Message-ID: <1139268392.2041.10.camel@mindpipe>
References: <200602062322.k16NMPda015556@auster.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200602062322.k16NMPda015556@auster.physics.adelaide.edu.au>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-02-07 at 09:52 +1030, Jonathan Woithe wrote:
> 
> I guess this is why Realtek recommend using drivers provided by the
> card/laptop manufacturer rather than the generic drivers - they have
> no control over what gets connected to what.
> 

IIRC the spec requires that this info be available from the BIOS, but
the problem is many vendors don't set it up correctly, as they can fall
back to vendor supplied drivers.

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
