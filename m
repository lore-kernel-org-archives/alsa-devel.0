From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [Alsa-user] emu10k1 alsamixer items
Date: Thu, 27 Jan 2005 13:41:20 -0500
Message-ID: <1106851280.25577.2.camel@krustophenia.net>
References: <1106091073.24484.60.camel@krustophenia.net>
	 <1106672990.27843.7.camel@radium.gaugetheory.org>
	 <1106678585.10845.8.camel@krustophenia.net>
	 <1106743059.30763.21.camel@radium.gaugetheory.org>
	 <1106756424.2935.1.camel@krustophenia.net>  <s5hu0p3nimh.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hu0p3nimh.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Brian L Scipioni <brian@gaugetheory.org>, alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2005-01-27 at 13:47 +0100, Takashi Iwai wrote:
> At Wed, 26 Jan 2005 11:20:24 -0500,
> Lee Revell wrote:
> > 
> > On Wed, 2005-01-26 at 07:37 -0500, Brian L Scipioni wrote:
> > > Is
> > > "music" MIDI?
> > 
> > Yes.  I posted a patch to alsa-devel to change this to "Synth" and it
> > was not accepted.  I did not get an explanation.
> 
> Maybe I overlooked.  Could you resend it?
> 
> 

The patch is here:

http://www.alsa-project.org/~rlrevell/emu10k1-multichannel-oldversions/change-music-to-synth.patch

(use patch -p0)

Summary: Changes "Music" to "Synth" in mixer control names.

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

Lee



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
