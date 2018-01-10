From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [ANNOUNCE] SOF 1.0 Release
Date: Wed, 10 Jan 2018 11:22:19 +0100
Message-ID: <0734cfd0-c0f7-20a1-40aa-6bd6c212573b@metafoo.de>
References: <1515525458.1844.203.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1515525458.1844.203.camel@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, "sound-open-firmware@alsa-project.org" <sound-open-firmware@alsa-project.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 01/09/2018 08:17 PM, Liam Girdwood wrote:
> I'd like to announce the 1.0 release of Sound Open Firmware (SOF) is
> available for download on git.alsa-project.org. 
> 
> SOF is an open source BSD licensed audio DSP firmware that currently
> runs on Cadence xtensa architecture DSPs found on Intel Baytrail,
> Braswell and Cherrytrail based devices, however SOF is architecture and
> platform independent meaning it's not tightly coupled to xtensa DSPs or
> Intel CPUs/SoCs.
> 
> The 1.0 release supports limited playback and capture topologies
> alongside volume, mixing and sample format conversion.
> 

Good job! This is a very important cornerstone in being able to continue to
provide good out-of-the-box audio support for systems which feature this
kind of hardware. Thanks for all the effort you and everybody else who
worked on this have put into it.

- Lars
